
Feature: Obtener producto por Id

  Scenario: CP-01 Obtener producto
  *  def idproducto = '497'
    Given url urlBase
    And path 'api/v1/producto/' + idproducto
    And header Accept = 'application/json'
    And header Authorization =  'Bearer 39|ijHkJCNAtVNOylLqwebVe75lkYGihz2hoMzywXTy'
    When method get
    Then status 200
