<#import "template.ftl" as layout>
<@layout.mainLayout active='account' bodyClass='user'; section>

    <form action="${url.accountUrl}" class="form-horizontal" method="post">

        <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

        <div class="form-group ${messagesPerField.printIfExists('email','has-error')}">
            <div class="${properties.kcInputWrapperClass!}">
                <label for="email" class="control-label">${msg("email")}</label>
            </div>

            <div class="${properties.kcInputWrapperClass!}">
                <input type="email" class="${properties.kcInputClass!}" id="email" name="email" autofocus
                       value="${(account.email!'')}" required/>
                <small class="d-block xs text-muted px-2">${msg("emailUpdateDesc")}</small>
            </div>
        </div>
        <#if !realm.registrationEmailAsUsername>
            <div class="form-group ${messagesPerField.printIfExists('username','has-error')}">
                <div class="${properties.kcInputWrapperClass!}">
                    <label for="username" class="control-label">${msg("username")}</label>
                </div>

                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" class="${properties.kcInputClass!}" id="username" name="username" required
                           value="${(account.username!'')}" title="${msg("usernameValid")}"
                           pattern="[a-zA-Z][a-zA-Z0-9-_.]{1,14}"/>
                    <small class="d-block xs text-muted px-2">${msg("req")} - ${msg("usernameDesc")}</small>
                </div>
            </div>
        </#if>

        <div class="form-group ${messagesPerField.printIfExists('firstName','has-error')}">
            <div class="${properties.kcInputWrapperClass!}">
                <label for="firstName" class="control-label">${msg("firstName")}</label>
            </div>

            <div class="${properties.kcInputWrapperClass!}">
                <input type="text" class="${properties.kcInputClass!}" id="firstName" name="firstName" value="${(account.firstName!'')}"/>
                <small class="d-block xs text-muted px-2">${msg("req")}</small>
            </div>
        </div>

        <div class="form-group ${messagesPerField.printIfExists('lastName','has-error')}">
            <div class="${properties.kcInputWrapperClass!}">
                <label for="lastName" class="control-label">${msg("lastName")}</label>
            </div>

            <div class="${properties.kcInputWrapperClass!}">
                <input type="text" class="${properties.kcInputClass!}" id="lastName" name="lastName" value="${(account.lastName!'')}"/>
                <small class="d-block xs text-muted px-2">${msg("req")}</small>
            </div>
        </div>

        <div class="${properties.kcFormGroupClass!}">
            <div class="${properties.kcInputWrapperClass!}">
                <p>To delete your account, please email us at <a
                            href="mailto:jakub.swacha@usz.edu.pl?subject=Delete%20account%20request&amp;body=Please%20remove%20my%20account%20from%20FGPE">jakub.swacha@usz.edu.pl</a>
                    with the subject line "Delete account request".</p>
            </div>
        </div>
        <div class="${properties.kcFormGroupClass!}">
            <div class="${properties.kcInputWrapperClass!}">
                <div class="form-buttons flex-row-reverse">
                    <input type="hidden" id="firstName" name="firstName" value="${(account.firstName!'-')}"/>
                    <input type="hidden" id="lastName" name="lastName" value="${(account.lastName!'-')}"/>
                    <input class="btn btn-primary" name="submitAction" type="submit" value="${msg("doUpdate")}"/>
                </div>
            </div>
        </div>
    </form>
</@layout.mainLayout>
