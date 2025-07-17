Feature: Loguear usuario

  @login
  Scenario: CP-01 Loguear usuario - Happy path
    Given url urlBase
    And path 'api/login'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request {"email": "paolaprueba@gmail.com", "password": "12345678" }
    When method post
    Then status 200
    * print response.access_token
    * def access_token = response.access_token
    And match response.user.email == "paolaprueba@gmail.com"
    And match response.token_type == "Bearer"


  Scenario: CP-02 Loguear usuario con el body en archivo json - Happy path
    Given url urlBase
    And path 'api/login'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request read('bodyLogin.json')
    * def arch = read('bodyLogin.json')
    * print arch
    * def correo = arch.email
    When method post
    Then status 200
    And match response.user.email == correo
    And match response.token_type == "Bearer"


  Scenario: CP-03 Loguear usuario - Valida password
    Given url urlBase
    And path 'api/login'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request {"email": "paolaprueba@gmail.com", "password": "123" }
    When method post
    Then status 401
    * print response
    And match response.message == "Datos incorrectos"

  Scenario: CP-04 Loguear usuario - Valido que envíe password en request
    Given url urlBase
    And path 'api/login'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request {"email": "paolaprueba@gmail.com" }
    When method post
    Then status 500
    * print response
    And match response.message == "Server Error"


  Scenario: CP-05 Loguear usuario - Valido que correo no existe
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
    And match response.message == "Datos incorrectos"
