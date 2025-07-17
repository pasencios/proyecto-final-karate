Feature: Registrar usuario

  Background:
    * def login = call read('classpath:bdd/auth/loginAuth.feature@login')
    * print login
    * def access_token = login.access_token
    * print access_token

  Scenario: CP-01 Registrar usuario
    Given url urlBase
    And path 'api/register'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer ' + access_token
    And request read('bodyRegister.json')
    * def arch = read('bodyRegister.json')
    * print arch
    * def nombre = arch.nombre
    * def correo = arch.email
    When method post
    Then status 200
    And match response.data.nombre == nombre
    And match response.data.email == correo
    And match response.data.estado == 1


  Scenario Outline: CP-02 Generacion por outline
    Given url urlBase
    And path 'api/register'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer ' + access_token
    And request
    """
    {
  "email": "<email>",
  "password": "<password>",
  "nombre": "<nombre>",
  "tipo_usuario_id": <tipo_usuario_id>,
  "estado": <estado>
    }
    """
    When method post
    Then status 200
    * def correo = "<email>"
    * def nombre  = "<nombre>"
    And match response.data.nombre == nombre
    And match response.data.email == correo
    And match response.data.estado == 1

    Examples:
      | email |  password | nombre | tipo_usuario_id|estado|
      |paolatest5@gmail.com     |12345678         |Paola        |1|1      |
      |karentest5@gmail.com     |12345678         |Karen        |1|1      |
      |ceciliatest5@gmail.com   |12345678         |Cecilia      |1|1      |


  Scenario: CP-03  Registrar usuario - Validacion de campo email requerido
    Given url urlBase
    And path 'api/register'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer ' + access_token
    And request
    """
    {
    "password": "12345678",
    "nombre": "Arantxa",
    "tipo_usuario_id": 1,
    "estado": 1
    }
    """
    When method post
    Then status 500
    And match response.email == ["The email field is required."]


  Scenario: CP-04 Registrar usuario - Validacion de campo email no puede ser null
    Given url urlBase
    And path 'api/register'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer ' + access_token
    * print access_token
    And request
    """
    {
    "email": null,
    "password": "12345678",
    "nombre": "Karina",
    "tipo_usuario_id": 1,
    "estado": 1
    }
    """
    When method post
    Then status 500
    And match response.email == ["The email field is required."]
