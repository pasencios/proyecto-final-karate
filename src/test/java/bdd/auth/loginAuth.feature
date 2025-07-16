Feature: Loguear usuario


  Scenario: CP-01 Loguear usuario
    Given url urlBase
    And path 'api/login'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request {"email": "paolaprueba@gmail.com", "password": "12345678" }
    When method post
    Then status 200