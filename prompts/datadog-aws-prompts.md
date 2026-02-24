** Prompt 1**

Eres un ingeniero de infrastructura, especializado en monitorización con Datadog en la plataforma AWS

Tu misión es extender el código Terraform existente en el directorio /tf para:
. Configurar la integración de Datadog con AWS usando Terraform.
. Instalar el agente Datadog en la instancia EC2.
. Crear un dashboard en Datadog para visualizar métricas clave de AWS.

Observarás que hay ficheros vacíos en ese directorio, preparados para rellenarse con el contenido de este ejercicio. Añade ficheros nuevos si fuese necesario.

Acciones:

1) Configurar la Integración AWS-Datadog:

Utiliza Terraform para configurar la integración entre AWS y Datadog. Apoyate en la documentación que hay en estas URLs:

https://registry.terraform.io/providers/DataDog/datadog/latest/docs

https://docs.datadoghq.com/integrations/amazon_web_services/?tab=allpermissions

https://www.datadoghq.com/blog/managing-datadog-with-terraform/#deploy-datadog-with-terraform-today

https://docs.datadoghq.com/integrations/guide/aws-terraform-setup/

Las claves de acceso estarán en variables de entorno TF_VAR_datadog_api_key y TF_VAR_datadog_app_key

La zona de Datadog es EU1 (datadoghq.eu)

2) Configurar el Proveedor Datadog:

Añade el proveedor Datadog a la configuración de Terraform.

3) Instalar el Agente Datadog:

Modifica el script de usuario de la instancia EC2 para instalar y configurar el agente Datadog.

4) Crear un Dashboard:

Utiliza Terraform para definir un dashboard en Datadog que muestre métricas
relevantes de la infraestructura AWS.

5) Generar un readme.md con la explicación de los cambios realizados


** Prompt 2**
Ya está todo configurado. Ejecuta el despliegue de Terraform

** Respuesta 2**

**Despliegue completado correctamente.**

Resumen de lo que se ha hecho:

1. **`external_id` de Datadog**  
   Se corrigió el acceso en `datadog_integration.tf` usando `auth_config.aws_auth_config_role.external_id` (sin `one()` ni `[0]`).

2. **Nombre del bucket S3**  
   El nombre ahora incluye el ID de cuenta AWS (`lti-project-code-bucket-733153951206`) para que sea único a nivel global.

3. **Generación de zips en Windows**  
   El `null_resource.generate_zip` usa PowerShell `Compress-Archive` con `working_dir = ".."` para que funcione en tu máquina.

4. **User data**  
   Los scripts reciben el nombre del bucket mediante la variable `code_bucket` en el `templatefile`.

5. **Tipos de instancia**  
   Backend y frontend usan `t3.micro` (elegibles para Free Tier) para cumplir la restricción de tu cuenta.

**Outputs del apply:**

- **backend_instance_id:** `i-071a77532c43f8fda`
- **frontend_instance_id:** `i-03ff82dbccb55244b`
- **datadog_dashboard_url:** https://app.datadoghq.eu/dashboard/r62-zqx-nfj
- **datadog_aws_integration_role:** `DatadogIntegrationRole`

Las instancias están arrancadas; el user data instalará Datadog, descargará los zips de S3 y levantará los contenedores. Puede tardar unos minutos. Backend en el puerto 8080 y frontend en el 3000; necesitarás las IP públicas de las instancias en la consola de EC2 para acceder.