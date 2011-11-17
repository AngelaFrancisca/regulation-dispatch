<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr"%>

<p>
	<html:link action="/regulationDispatch.do?method=prepare">
		<bean:message key="link.back" bundle="REGULATION_DISPATCH_RESOURCES" />
	</html:link>
</p>

<h2 class="mtop20px mbottom20px">
	<bean:message key="title.regulation.dispatch.system.management" bundle="REGULATION_DISPATCH_RESOURCES" />
</h2>


<logic:empty name="queues">
	Não foram criadas filas para a gestão dos despachos
</logic:empty>

<p>
	<html:link action="/manageRegulationDispatchQueues.do?method=prepareCreateQueue">
		<bean:message key="link.regulation.dispatch.create.system" bundle="REGULATION_DISPATCH_RESOURCES" />
	</html:link>
</p>

<logic:notEmpty name="queues">
	
		
	<fr:view name="queues">
		<fr:schema type="module.regulation.dispatch.domain.RegulationDispatchQueue" bundle="REGULATION_DISPATCH_RESOURCES">
			<fr:slot name="name" />
			<fr:slot name="processesCount" />
		</fr:schema>
		
		<fr:layout name="tabular">
			<fr:property name="classes" value="tstyle2 mtop20px" />
			
			<fr:link name="view" link="/manageRegulationDispatchQueues.do?method=viewQueue&amp;queueId=${externalId}"
				label="link.view,REGULATION_DISPATCH_RESOURCES" />
		</fr:layout>
	</fr:view>
	
</logic:notEmpty>

