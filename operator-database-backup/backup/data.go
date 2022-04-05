package backup

import (
	"fmt"
	"io/ioutil"
	"net/http"
)

func readData() string {
	leaderAddress := "http://database-cluster-0.database-service.database:8089/persons"
	errorMessage := "Could not read data from " + leaderAddress
	output := "{}"
	response, err := http.Get(leaderAddress)
	if err != nil {
		fmt.Println(errorMessage)
	} else {
		body, err := ioutil.ReadAll(response.Body)
		if err != nil {
			fmt.Println(errorMessage)
		} else {
			output = string(body)
		}
	}
	return output
}
