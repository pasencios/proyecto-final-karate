Feature: Loguear usuario


  Scenario: CP-01 Loguear usuario - Happy path
    Given url urlBase
    And path 'api/login'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request {"email": "paolaprueba@gmail.com", "password": "12345678" }
    When method post
    Then status 200

  Scenario: CP Loguear usuario - Valida password
    Given url urlBase
    And path 'api/login'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request {"email": "paolaprueba@gmail.com", "password": "123" }
    When method post
    Then status 401
    * print response
    And response.message = "Datos incorrectos"

  Scenario: CP Loguear usuario - Valido que envíe password en request
    Given url urlBase
    And path 'api/login'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request {"email": "paolaprueba@gmail.com" }
    When method post
    Then status 500
    * print response
    And response.message = "Server Error"


  Scenario: CP-02 Loguear usuario con el body en archivo json - Happy path
    Given url urlBase
    And path 'api/login'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request read('bodylogin.json')
    When method post
    Then status 200


  Scenario: CP Loguear usuario - Valido que correo no existe
    Given url urlBase
    And path 'api/login'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request
     """
      {"email": "paola888888@gmail.com", "password": "123" }
      """
    When method post
    Then status 401
    * print response
    And response.message = "Datos incorrectos"
