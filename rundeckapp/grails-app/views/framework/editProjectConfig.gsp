%{--
  - Copyright 2015 SimplifyOps, Inc. (http://simplifyops.com)
  -
  - Licensed under the Apache License, Version 2.0 (the "License");
  - you may not use this file except in compliance with the License.
  - You may obtain a copy of the License at
  -
  -        http://www.apache.org/licenses/LICENSE-2.0
  -
  - Unless required by applicable law or agreed to in writing, software
  - distributed under the License is distributed on an "AS IS" BASIS,
  - WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  - See the License for the specific language governing permissions and
  - limitations under the License.
  --}%
<%--
   Author: Greg Schueler <a href="mailto:greg@simplifyops.com">greg@simplifyops.com</a>
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="base"/>
    <meta name="tabpage" content="projectconfigure"/>
    <meta name="projtabtitle" content="${message(code:'configuration')}"/>
    <title><g:message code="project.config.editor.title" default="Edit Project Configuration File"/></title>

    <asset:javascript src="prototype/effects"/>
    <asset:javascript src="leavePageConfirm.js"/>
    <g:jsMessages code="page.unsaved.changes"/>
    <g:javascript>

    function init(){
        $$('input').each(function(elem){
            if(elem.type=='text'){
                elem.observe('keypress',noenter);
            }
        });
        var confirm = new PageConfirm(message('page.unsaved.changes'));
        jQuery('.apply_ace').each(function () {
            _setupAceTextareaEditor(this,confirm.setNeetsConfirm);
        });
    }
    jQuery(init);
    </g:javascript>
</head>

<body>
<div class="content">
<div id="layoutBody">
  <div class="container-fluid">
    <div class="row">
      <div class="col-sm-12">
        <g:render template="/common/messages"/>
      </div>
    </div>
    <div class="row">
      <g:form action="saveProjectConfig" method="post" params="${[project:params.project]}" useToken="true" onsubmit="" class="form">
      <div class="col-xs-12">
        <div class="card"  id="createform">
          <div class="card-header">
            <h3 class="card-title">
              <g:message code="project.config.edit.message" default="Edit Project Configuration File"/>: <g:enc>${params.project ?: request.project}</g:enc>
              <g:link controller="framework" action="editProject"
                      params="[project: params.project ?: request.project]"
                      class="pull-right btn btn-default btn-sm"
                      >
                  <!-- <g:icon name="edit"/> -->
                  <g:message code="page.admin.EditProjectSimple.button" default="Simple Configuration"/>
              </g:link>
            </h3>
          </div>
          <div class="card-content">
            <div class="help-block">
              <g:markdown><g:message code="project.config.editor.help.markdown" /></g:markdown>
            </div>
            <textarea name="projectConfig" class="form-control code apply_ace" data-ace-autofocus='true' data-ace-session-mode="properties" data-ace-height="500px" data-ace-control-soft-wrap="true">${projectPropertiesText}</textarea>
          </div>
          <div class="card-footer">
              <g:submitButton name="cancel" value="${g.message(code:'button.action.Cancel',default:'Cancel')}" class="btn btn-default reset_page_confirm"/>
              <g:submitButton name="save" value="${g.message(code:'button.action.Save',default:'Save')}" class="btn btn-cta reset_page_confirm"/>
          </div>
        </div>
      </div>
      </g:form>
    </div>
  </div>
</div>
</div>
<!--[if (gt IE 8)|!(IE)]><!--> <asset:javascript src="ace-bundle.js"/><!--<![endif]-->

</body>
</html>
