Feature: Adicionar nuevo producto

  Background:
    * def login = call read('classpath:bdd/auth/loginAuth.feature@login')
    * print login
    * def access_token = login.access_token
    * print access_token

  Scenario: CP-01 Adicionar producto por JSON
    Given url urlBase
    And path 'api/v1/producto'
    And header Accept = 'application/json'
    And header Content-Type =  'application/json'
    And header Authorization = 'Bearer ' + access_token
    And request read('productRegister.json')
    * def arch = read('productRegister.json')
    * print arch
    * def codigo = arch.codigo
    * def nombre = arch.nombre
    When method post
    Then status 200
    And match response.codigo == codigo
    And match response.nombre == nombre



  Scenario Outline: CP-02 Adicionar nuevo producto por csv

    Given url urlBase
    And path 'api/v1/producto'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And header Authorization =  'Bearer ' + access_token
    And request
    """
    {
      "codigo" : "#(codigo)",
      "nombre" : "#(nombre)",
      "medida" : #(medida),
      "marca" : #(marca),
      "categoria" : #(categoria),
      "precio" : #(precio),
      "stock" : #(stock),
      "estado" : #(estado),
      "descripcion" : "#(descripcion)"
    }
    """
    * def arch = read('newProduct.csv')
    * print arch
    When method post
    Then status 200
    And match response.codigo == 'K00009'
    Examples:
      | read('newProduct.csv') |

