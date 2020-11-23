# fgpe-keycloak-theme

Keycloak theme for the Erasmus+ project named Framework for Gamified Programming Education.


## Developer Guide


### Run Keycloak with Docker Compose

From project root run:

```
npm install
```

With Docker running, and Compose installed, do:

```
KEYCLOAK_PASSWORD=password npm run dev
```

This will build a Docker image for Keycloak from the supplied [Dockerfile](./dev/Dockerfile) and run is as a Compose service to test the custom [theme](./theme). A [bind mount](https://docs.docker.com/storage/bind-mounts/) is used to mount the project's theme directory to the container. Caching for themes is turned off so any changes in .flt, .properties or .css files in [theme](./theme) directory can be previewed by reloading the page.

In addition, a service for SMTP mail will be running so that password validation and reset may be tested.

### Setup a realm

Go to Keycloak's admin login page: http://localhost:10001/auth/admin/

Login using the `KEYCLOAK_USER` ("admin") and `KEYCLOAK_PASSWORD` ("password") credentials.

Go to the "Add realm" page: http://localhost:10001/auth/admin/master/console/#/create/realm

Upload the supplied [fgpe-realm.json](./keycloak/fgpe-realm.json) file and press `Create`.
This creates a "fgpe" realm with login, email and theme settings, and
authentication flows all pre-configured.

## Testing the theme

Sign out of the admin console, and go to http://localhost:10001/auth/realms/fgpe/account where you will see the custom theme.


## Theme updates

Directory [theme](./theme) contains all the files for the custom theme.

Directory [scss](./scss) contains the SCSS files used to build the theme CSS. Compiled CSS for theme can be found in [theme resources](./theme/login/resources/css)

For theme updates to the SCSS do:

```
npm run scss:watch
```

Changes can be previewed by reloading the Keycloak URL.


## License

Licensed under the GPL v3.

For full details, see [LICENSE](LICENSE).
