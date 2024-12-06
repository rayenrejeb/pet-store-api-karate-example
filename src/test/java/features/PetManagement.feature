Feature: Pet Management Tests

  Background:
    # Set base URL and common headers for the API
    * url 'https://petstore.swagger.io/v2'
    * def petId = 12345
    * def petData = { "id": #(petId), "name": "Buddy", "status": "available" }

  Scenario: Create a new pet and validate the response
    Given path 'pet'
    And request petData
    When method POST
    Then status 200
    And match response.id == petId
    And match response.name == 'Buddy'
    And match response.status == 'available'

  Scenario: Retrieve the pet and verify data
    Given path 'pet', petId
    When method GET
    Then status 200
    And match response.id == petData.id
    And match response.name == petData.name
    And match response.status == petData.status

  Scenario: Update pet information
    # Modify pet's status and name
    * def updatedPetData = { "id": #(petId), "name": "Buddy", "status": "sold" }

    Given path 'pet'
    And request updatedPetData
    When method PUT
    Then status 200
    And match response.status == 'sold'

    # Validate the change was applied by retrieving the pet again
    Given path 'pet', petId
    When method GET
    Then status 200
    And match response.status == 'sold'
    And match response.name == 'Buddy'

  Scenario: Delete the pet and confirm deletion
    Given path 'pet', petId
    When method DELETE
    Then status 200

    # Confirm deletion by attempting to retrieve the pet
    Given path 'pet', petId
    When method GET
    Then status 404
    And match response.message contains 'Pet not found'