<%--
- menu.jsp
-
- Copyright (C) 2012-2023 Rafael Corchuelo.
-
- In keeping with the traditional purpose of furthering education and research, it is
- the policy of the copyright owner to permit non-commercial use and redistribution of
- this software. It has been tested carefully, but it is not guaranteed for any particular
- purposes.  The copyright owner does not offer any warranties or representations, nor do
- they accept any liabilities with respect to them.
--%>

<%@page language="java" import="acme.framework.helpers.PrincipalHelper,acme.roles.Provider,acme.roles.Consumer"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="acme" uri="http://www.the-acme-framework.org/"%>

<acme:menu-bar code="master.menu.home">
	<acme:menu-left>
		<acme:menu-option code="master.menu.anonymous" access="isAnonymous()">
			<acme:menu-suboption code="master.menu.anonymous.favourite-link" action="https://soymotor.com/"/>
			<acme:menu-suboption code="master.menu.anonymous.favourite-link2" action="https://google.com"/>
			<acme:menu-suboption code="master.menu.anonymous.favourite-link3" action="https://youtube.com"/>
			<acme:menu-suboption code="master.menu.anonymous.favourite-link4" action="https://www.twitch.tv"/>
			<acme:menu-suboption code="master.menu.anonymous.favourite-link5" action="https://www.skyscanner.com"/>
			<acme:menu-suboption code="master.menu.any.course.list-all" action="/any/course/list-all"/>
			<acme:menu-suboption code="master.menu.any.peep.list-all" action="/any/peep/list-all"/>
		</acme:menu-option>

		<acme:menu-option code="master.menu.administrator" access="hasRole('Administrator')">
			<acme:menu-suboption code="master.menu.administrator.user-accounts" action="/administrator/user-account/list"/>
			<acme:menu-separator/>


			<acme:menu-suboption code="master.menu.administrator.banner" action="/administrator/banner/list"/>
			<acme:menu-separator/>
			<acme:menu-suboption code="master.menu.administrator.populate-initial" action="/administrator/populate-initial"/>
			<acme:menu-suboption code="master.menu.administrator.populate-sample" action="/administrator/populate-sample"/>
			<acme:menu-separator/>
			<acme:menu-suboption code="master.menu.administrator.system-configuration" action="/administrator/system-configuration/update"/>			
			<acme:menu-separator/>
			<acme:menu-suboption code="master.menu.administrator.shut-down" action="/administrator/shut-down"/>
			<acme:menu-separator/>
			<acme:menu-suboption code="master.menu.authenticated.bulletin.create" action="/administrator/bulletin/create" access="isAuthenticated()"/>
			<acme:menu-suboption code="master.menu.administrator.offer.create" action="/administrator/offer/create"/>
			<acme:menu-separator/>
			<acme:menu-suboption code="master.menu.administrator.offer.list-all" action="/administrator/offer/list-all"/>
			
			
		</acme:menu-option>
		
		<acme:menu-option code="master.menu.assistant" access="hasRole('Assistant')">
			<acme:menu-suboption code="master.menu.authenticated.tutorial.list-all" action="/assistant/tutorial/list-all"/>
		<%-- 	<acme:menu-suboption code="master.menu.assistant.assistantDashboard" action="/assistant/assistant-dashboard/show"/> --%>
		</acme:menu-option>
		
		<acme:menu-option code="master.menu.auditor" access="hasRole('Auditor')">
			<acme:menu-suboption code="master.menu.auditor.audit.list-all" action="/auditor/audit/list-all"/>
		</acme:menu-option>

		<acme:menu-option code="master.menu.company" access="hasRole('Company')">
			  <acme:menu-suboption code="master.menu.authenticated.practicum.list-all" action="/company/practicum/list-all"/>
			  <acme:menu-suboption code="master.menu.company.practicum.create" action="/company/practicum/create"/>
		</acme:menu-option>
		
		<acme:menu-option code="master.menu.lecturer" access="hasRole('Lecturer')">
			<acme:menu-suboption code="master.menu.lecturer.course.create" action="/lecturer/course/create"/>
			<acme:menu-suboption code="master.menu.lecturer.course.list" action="/lecturer/course/list"/>	
			<acme:menu-separator/>
			<acme:menu-suboption code="master.menu.lecturer.lecture.create" action="/lecturer/lecture/create"/>
			<acme:menu-suboption code="master.menu.lecturer.lecture.list" action="/lecturer/lecture/list-all"/>
			<acme:menu-separator/>
		</acme:menu-option>
		
		<acme:menu-option code="master.menu.student" access="hasRole('Student')">
			<acme:menu-suboption code="master.menu.student.enrolment.list-all" action="/student/enrolment/list-all"/>
			<acme:menu-suboption code="master.menu.student.course.list-all" action="/student/course/list-all"/>
		</acme:menu-option>
		
		
	</acme:menu-left>

	<acme:menu-right>
		<acme:menu-option code="master.menu.sign-up" action="/anonymous/user-account/create" access="isAnonymous()"/>
		<acme:menu-option code="master.menu.sign-in" action="/master/sign-in" access="isAnonymous()"/>


		<acme:menu-option code="master.menu.user-account" access="isAuthenticated()">

		<acme:menu-suboption code="master.menu.authenticated.bulletin.list-all" action="/authenticated/bulletin/list-all"/>
		
		<acme:menu-suboption code="master.menu.authenticated.note.list-all" action="/authenticated/note/list-all"/>

		
    
		<acme:menu-suboption code="master.menu.authenticated.offer.list-all" action="/authenticated/offer/list-all"/>
		
		<acme:menu-suboption code="master.menu.any.course.list-all" action="/any/course/list-all"/>
			<acme:menu-suboption code="master.menu.any.peep.list-all" action="/any/peep/list-all"/>
			<acme:menu-suboption code="master.menu.user-account.general-data" action="/authenticated/user-account/update"/>
			<acme:menu-suboption code="master.menu.user-account.become-assistant" action="/authenticated/assistant/create" access="!hasRole('Assistant')"/>
			<acme:menu-suboption code="master.menu.user-account.assistant" action="/authenticated/assistant/update" access="hasRole('Assistant')"/>
			<acme:menu-suboption code="master.menu.user-account.become-company" action="/authenticated/company/create" access="!hasRole('Company')"/>
			<acme:menu-suboption code="master.menu.user-account.company" action="/authenticated/company/update" access="hasRole('Company')"/>
			<acme:menu-suboption code="master.menu.user-account.consumer" action="/authenticated/consumer/update" access="hasRole('Consumer')"/>
			<acme:menu-suboption code="master.menu.user-account.become-auditor" action="/authenticated/auditor/create" access="!hasRole('Auditor')"/>
			<acme:menu-suboption code="master.menu.user-account.auditor" action="/authenticated/auditor/update" access="hasRole('Auditor')"/>
			<acme:menu-suboption code="master.menu.user-account.become-student" action="/authenticated/student/create" access="!hasRole('Student')"/>
			<acme:menu-suboption code="master.menu.user-account.student" action="/authenticated/student/update" access="hasRole('Student')"/>
			<acme:menu-suboption code="master.menu.user-account.become-lecturer" action="/authenticated/lecturer/create" access="!hasRole('Lecturer')"/>
		</acme:menu-option>

		<acme:menu-option code="master.menu.sign-out" action="/master/sign-out" access="isAuthenticated()"/>
	</acme:menu-right>
</acme:menu-bar>

