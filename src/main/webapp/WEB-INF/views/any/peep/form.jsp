<%--
- form.jsp
-
- Copyright (C) 2012-2023 Rafael Corchuelo.
-
- In keeping with the traditional purpose of furthering education and research, it is
- the policy of the copyright owner to permit non-commercial use and redistribution of
- this software. It has been tested carefully, but it is not guaranteed for any particular
- purposes.  The copyright owner does not offer any warranties or representations, nor do
- they accept any liabilities with respect to them.
--%>

<%@page language="java"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="acme" uri="http://www.the-acme-framework.org/"%>

<acme:form>
	<acme:input-textbox code="any.peep.list.label.title" path="title"/>
	<acme:input-textbox code="any.peep.list.label.nick" path="nick"/>
	<acme:input-textbox code="any.peep.list.label.mail" path="mail"/>
	<acme:input-textarea code="any.peep.list.label.message" path="message"/>
	<acme:input-url code="any.peep.list.label.link" path="link"/>
	
	<jstl:if test="${_command == 'create'}">
		<acme:submit code="any.peep.form.button.create" action="/any/peep/create"/>
	</jstl:if>
</acme:form>
