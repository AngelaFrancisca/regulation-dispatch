<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr"%>

<bean:define id="queueId" name="queue" property="externalId" />
<bean:define id="dispatchId" name="dispatch" property="externalId" />


<p>
	<html:link action="/regulationDispatch.do?method=viewQueue" paramId="queueId" paramName="queueId"> 
		Voltar 
	</html:link>
</p>

<h1> Editar despacho </h1>

<fr:form action="<%= String.format("/createRegulationDispatch.do?method=edit&amp;queueId=%s&amp;dispatchId=%s", queueId, dispatchId) %>">

	<fr:edit id="bean" name="bean" visible="false" />

	<fr:edit id="bean-create" name="bean">
		<fr:schema type="module.regulation.dispatch.domain.activities.RegulationDispatchActivityInformation" bundle="REGULATION_DISPATCH_RESOURCES">
			<fr:slot name="reference" required="true"/>
			<fr:slot name="emissionDate" required="true" />
			<fr:slot name="dispatchDescription" required="true" />
			<fr:slot name="regulationReference" />
			<fr:slot name="emissor" layout="autoComplete"
				validator="pt.ist.fenixWebFramework.rendererExtensions.validators.RequiredAutoCompleteSelectionValidator">
				
		        <fr:property name="labelField" value="name"/>
				<fr:property name="format" value="${partyName} (${user.username})"/>
				<fr:property name="minChars" value="3"/>
				<fr:property name="args" value="provider=module.organization.presentationTier.renderers.providers.PersonAutoCompleteProvider"/>
				<fr:property name="size" value="60"/>
			</fr:slot>
		</fr:schema>
		
		<fr:destination name="invalid" path="<%= String.format("/createRegulationDispatch.do?method=editInvalid&amp;queueId=%s&amp;dispatchId=%s", queueId, dispatchId) %>"/>
		<fr:destination name="cancel" path="<%= "/regulationDispatch.do?method=viewQueue&amp;queueId=" + queueId %>"/>

		<fr:layout name="tabular">
			<fr:property name="classes" value="tstyle1" />
		</fr:layout>
		
	</fr:edit>
	
	<p>
		<html:submit>Editar</html:submit>
	</p>
	
</fr:form>

<hr />

<h1> Inserir documento </h1>

<fr:form action="<%= String.format("/createRegulationDispatch.do?method=upload&amp;queueId=%s&amp;dispatchId=%s", queueId, dispatchId) %>" encoding="multipart/form-data">
	<fr:edit id="bean" name="bean" visible="false" />
	
	<fr:edit id="bean-upload" name="bean">
		<fr:schema type="module.regulation.dispatch.domain.activities.RegulationDispatchActivityInformation" bundle="REGULATION_DISPATCH_RESOURCES">
			<fr:slot name="file" required="true" >
				<fr:property name="fileNameSlot" value="fileName" />
				<fr:property name="fileSizeSlot" value="fileSize" />
				<fr:property name="fileContentTypeSlot" value="mimeType" />
			</fr:slot>
		</fr:schema>

		<fr:destination name="invalid" 
			path="<%= String.format("/createRegulationDispatch.do?method=uploadInvalid&amp;queueId=%s&amp;dispatchId=%s", queueId, dispatchId) %>"/>
		
		<fr:layout name="tabular">
			<fr:property name="classes" value="tstyle1" />
		</fr:layout>
	</fr:edit>
	
	<p>
		<html:submit>Submeter</html:submit>
	</p>
</fr:form>

<h1> Documentos </h1>

<fr:view name="dispatch" property="files">
	<fr:schema type="module.regulation.dispatch.domain.RegulationDispatchProcessFile" bundle="REGULATION_DISPATCH_RESOURCES">
		<fr:slot name="displayName" />
		<fr:slot name="creationDate" />
		<fr:slot name="active" />
		<fr:slot name="mainDocument" />
	</fr:schema>
	
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2" />

		<fr:link name="download" 
			link="<%= String.format("/createRegulationDispatch.do?method=download&amp;queueId=%s&amp;dispatchId=%s&amp;fileId=${externalId}", queueId, dispatchId) %>" 
			label="link.download,REGULATION_DISPATCH_RESOURCES" />
			
		<fr:link name="remove" 
			link="<%= String.format("/createRegulationDispatch.do?method=removeFile&amp;queueId=%s&amp;dispatchId=%s&amp;fileId=${externalId}", queueId, dispatchId) %>"
			label="link.remove,REGULATION_DISPATCH_RESOURCES" 
			condition="ableToRemove" />
			
		<fr:link name="mainDocument" 
			link="<%= String.format("/createRegulationDispatch.do?method=putFileAsMainDocument&amp;queueId=%s&amp;dispatchId=%s&amp;fileId=${externalId}", queueId, dispatchId) %>"
			label="link.module.regulation.dispatch.domain.RegulationDispatchProcessFile.asMainDocument,REGULATION_DISPATCH_RESOURCES" 
			condition="ableToSetAsMainDocument" />
	</fr:layout>
		
</fr:view>
