
Feature: Obtener producto por Id

  Background:
    * def login = call read('classpath:bdd/auth/loginAuth.feature@login')
    * print login
    * def access_token = login.access_token
    * print access_token

  Scenario: CP-01 Obtener producto
  *  def idproducto = 497
    Given url urlBase
    And path 'api/v1/producto/' + idproducto
    And header Accept = 'application/json'
    And header Authorization = 'Bearer ' + access_token
    * print 'token:' + access_token
    When method get
    Then status 200
    * print response
    And match response.id == idproducto

  Scenario: CP-02 Obtener producto - Validar codigo de producto
    *  def idproducto = null
    Given url urlBase
    And path 'api/v1/producto/' + idproducto
    And header Accept = 'application/json'
    And header Authorization = 'Bearer ' + access_token
    When method get
    Then status 404
    * print response
    And match response.error == "Producto no encontrado"