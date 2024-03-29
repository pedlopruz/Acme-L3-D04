
package acme.features.auditor.auditingRecord;

import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import acme.entities.Audit;
import acme.entities.AuditingRecord;
import acme.entities.MarkType;
import acme.framework.components.jsp.SelectChoices;
import acme.framework.components.models.Tuple;
import acme.framework.helpers.MomentHelper;
import acme.framework.services.AbstractService;
import acme.roles.Auditor;

@Service
public class AuditorAuditingRecordCreateExceptionalService extends AbstractService<Auditor, AuditingRecord> {
	// Internal state ---------------------------------------------------------

	@Autowired
	protected AuditorAuditingRecordRepository repository;

	// AbstractService interface ----------------------------------------------


	@Override
	public void check() {
		Boolean status;
		status = super.getRequest().hasData("auditId", int.class);
		super.getResponse().setChecked(status);
	}

	@Override
	public void authorise() {
		boolean status;
		int auditId;
		Audit audit;

		auditId = super.getRequest().getData("auditId", int.class);
		audit = this.repository.findOneAuditById(auditId);
		status = audit != null && !audit.isDraftMode() && super.getRequest().getPrincipal().hasRole(audit.getAuditor());

		super.getResponse().setAuthorised(status);
	}

	@Override
	public void load() {
		AuditingRecord object;
		int auditId;
		Audit audit;

		auditId = super.getRequest().getData("auditId", int.class);
		audit = this.repository.findOneAuditById(auditId);

		object = new AuditingRecord();
		object.setSubject("");
		object.setAssessment("");
		object.setExceptional(true);
		object.setAudit(audit);

		super.getBuffer().setData(object);
	}

	@Override
	public void bind(final AuditingRecord object) {
		assert object != null;

		super.bind(object, "subject", "assessment", "markType", "initialPeriod", "finalPeriod", "exceptional", "link");

	}

	@Override
	public void validate(final AuditingRecord object) {
		if (!super.getBuffer().getErrors().hasErrors("initialPeriod")) {
			long diferenciaHoras = 0;
			final long num = 1;
			final Date moment = MomentHelper.getCurrentMoment();
			final Date initialPeriod = object.getInitialPeriod();
			final long milisegundosInicio = moment.getTime();
			final long milisegundosFin = initialPeriod.getTime();
			final long diferenciaMilisegundos = milisegundosFin - milisegundosInicio;

			if (diferenciaMilisegundos > 0)
				diferenciaHoras = TimeUnit.MILLISECONDS.toHours(diferenciaMilisegundos);

			super.state(diferenciaHoras < num, "initialPeriod", "auditor.auditingRecord.form.error.antes");
		}

		if (!super.getBuffer().getErrors().hasErrors("finalPeriod")) {

			long diferenciaHorasMin = 0;
			final Date initialPeriod = object.getInitialPeriod();
			final Date finalPeriod = object.getFinalPeriod();
			final long milisegundosInicio = initialPeriod.getTime();
			final long milisegundosFin = finalPeriod.getTime();
			final long diferenciaMilisegundosMin = milisegundosFin - milisegundosInicio;
			diferenciaHorasMin = TimeUnit.MILLISECONDS.toHours(diferenciaMilisegundosMin);

			final long numMin = 1;
			super.state(MomentHelper.isAfter(object.getFinalPeriod(), object.getInitialPeriod()), "finalPeriod", "auditor.auditingRecord.form.error.menor");
			super.state(diferenciaHorasMin >= numMin, "finalPeriod", "auditor.auditingRecord.form.error.horaMin");

		}

	}

	@Override
	public void perform(final AuditingRecord object) {
		assert object != null;
		this.repository.save(object);
	}

	@Override
	public void unbind(final AuditingRecord object) {

		assert object != null;

		SelectChoices choices;
		Tuple tuple;
		choices = SelectChoices.from(MarkType.class, object.getMarkType());

		tuple = super.unbind(object, "subject", "assessment", "markType", "initialPeriod", "finalPeriod", "exceptional", "link");
		tuple.put("auditId", super.getRequest().getData("auditId", int.class));
		tuple.put("markTypes", choices);
		tuple.put("draftMode", object.getAudit().isDraftMode());
		super.getResponse().setData(tuple);
	}
}
