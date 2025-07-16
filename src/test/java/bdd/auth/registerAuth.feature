Feature: Registrar usuario


  Scenario: CP-01 Registrar usuario
    Given url urlBase
    And path 'api/register'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer 161|gLTSveTBJXcFBfRdJUyfGaAQBqcnEtSUdCJKBKSb'
    And request read('bodyRegister.json')
    When method post
    Then status 200
    * print response.access_token
    * def access_token = response.access_token

  Scenario Outline: CP-02 Generacion por outline
    Given url urlBase
    And path 'api/register'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer 161|gLTSveTBJXcFBfRdJUyfGaAQBqcnEtSUdCJKBKSb'
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

    Examples:
      | email |  password | nombre | tipo_usuario_id|estado|
      |paolatest1@gmail.com     |123456         |Paola        |1|1      |
      |karentest1@gmail.com     |123456         |Karen        |1|1      |
      |ceciliatest1@gmail.com   |123456         |Cecilia      |1|1      |


  Scenario: CP Registrar usuario - Validacion de campo email requerido
    Given url urlBase
    And path 'api/register'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer 161|gLTSveTBJXcFBfRdJUyfGaAQBqcnEtSUdCJKBKSb'
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
    * print response
    And response.message = "The email field is required."


  Scenario: CP Registrar usuario - Validacion de campo email no puede ser null
    Given url urlBase
    And path 'api/register'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer 161|gLTSveTBJXcFBfRdJUyfGaAQBqcnEtSUdCJKBKSb'
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
    * print response
    And response.message = "The email field is required."

