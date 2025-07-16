Feature: Actualizar producto

  Background:
    * def login = call read('classpath:bdd/auth/loginAuth.feature@login')
    * def access_token = login.access_token

  Scenario: CP-01 Actualizar producto
    * def idproducto = '543'
    Given url urlBase
    And path 'api/v1/producto/' + idproducto
    And header Accept = 'application/json'
    And header Content-Type =  'application/json'
    And header Authorization = 'Bearer ' + access_token
    And request read('updateProduct.json')
    * def arch = read('updateProduct.json')
    * print arch
    * def codigo = arch.codigo
    * def nombre = arch.nombre
    * def precio = arch.precio
    When method put
    Then status 200
    And match response.codigo == codigo
    And match response.nombre == nombre
    And match response.precio == precio



  Scenario Outline: CP-02 Actualización de productos por outline
    Given url urlBase
    And path 'api/v1/producto/' + <id>
    And header Accept = 'application/json'
    And header Content-Type =  'application/json'
    And header Authorization = 'Bearer ' + access_token
    And request
    """
    {
      "codigo" : "<codigo>",
      "nombre" : "<nombre>",
      "medida" : <medida>,
      "marca" : <marca>,
      "categoria" : <categoria>,
      "precio" : <precio>,
      "stock" : <stock>,
      "estado" : <estado>,
      "descripcion" : "<descripcion>"
    }
    """
    When method put
    Then status 200
    * def codigo = "<codigo>"
    * def nombre  = "<nombre>"
    And match response.codigo == codigo
    And match response.nombre == nombre

    Examples:
      |id| codigo |  nombre | medida | marca|categoria|precio|stock|estado|descripcion|
      | 543 |K00001 |Llanta repuesto Nissan |UND |Generico| Repuestos|3200|100  |1 | Llanta repuesto Nissan |
      | 546 |K00004 |Llanta repuesto Mazda  |UND |Generico| Repuestos|2500|100  |1 |LLanta repuesto Mazda |