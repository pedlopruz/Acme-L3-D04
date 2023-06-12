
package acme.entities;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PastOrPresent;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.URL;

import acme.framework.data.AbstractEntity;
import acme.framework.helpers.MomentHelper;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Banner extends AbstractEntity {

	protected static final long	serialVersionUID	= 1L;

	@PastOrPresent
	@NotNull(message = "{validation.banner.notNull}")
	@Temporal(TemporalType.TIMESTAMP)
	protected Date				instantiation;

	@Temporal(TemporalType.DATE)
	@NotNull(message = "{validation.banner.notNull}")
	protected Date				inicialPeriod;

	@Temporal(TemporalType.DATE)
	@NotNull(message = "{validation.banner.notNull}")
	protected Date				finalPeriod;

	@NotBlank(message = "{validation.banner.notNull}")
	@Length(min = 1, max = 75)
	protected String			slogan;

	@URL
	@NotBlank(message = "{validation.banner.notNull}")
	protected String			link;

	@URL
	@NotBlank(message = "{validation.banner.notNull}")
	protected String			linkImage;


	public Boolean isActive() {
		boolean active = false;
		final Date currentMoment = MomentHelper.getCurrentMoment();
		if (currentMoment.after(this.inicialPeriod) && currentMoment.before(this.finalPeriod))
			active = true;
		else
			active = false;

		return active;
	}

}
