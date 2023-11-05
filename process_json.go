// Process a JSON file and return a map of the data
// Write the results to a csv file
//
// Usage: process_json.go <filename.json>
// Example: process_json.go 1692416726.json
//

// Pass in file name as argument
// Check if file exists
// If file exists

// Open file
// Read file
// Parse file
// Write to csv file

package main

import (
	"encoding/csv"
	"encoding/json"
	"fmt"
	"io"
	"os"
	"strings"
)

func main() {

	json_filename := os.Args[1]
	var filename string

	// Open our jsonFile
	jsonFile, err := os.Open(json_filename) // "1692416726.json")
	// if we os.Open returns an error then handle it
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	fmt.Printf("Successfully Opened %s", json_filename)

	// Get filename without extension
	// https://stackoverflow.com/questions/42538560/how-to-get-file-name-without-extension-in-go
	// https://golang.org/pkg/strings/#Split
	// https://golang.org/pkg/strings/#Fields
	// https://golang.org/pkg/strings/#SplitAfter
	// https://golang.org/pkg/strings/#SplitN
	// https://golang.org/pkg/strings/#SplitAfterN
	// https://golang.org/pkg/strings/#SplitAfterN
	// https://golang.org/pkg/strings/#SplitN
	//
	filename = strings.TrimSuffix(json_filename, ".json")

	// filename = strings.Split(json_filename, ".")[0]

	fmt.Println(filename)

	// defer the closing of our jsonFile so that we can parse it later on
	defer jsonFile.Close()
	// read our opened xmlFile as a byte array.
	byteValue, _ := io.ReadAll(jsonFile)

	// Open the csv file for writing
	csv_filename := filename + ".csv"
	fmt.Println(csv_filename)
	csv_file, err := os.Create(csv_filename)
	if err != nil {
		panic(err)
	}
	defer csv_file.Close()

	// Create a csv writer
	csv_writer := csv.NewWriter(csv_file)
	defer csv_writer.Flush()

	// Write Headers
	csv_writer.Write([]string{"Now", "Hex", "Flight", "Lat", "Lon", "Alt", "Track", "Speed", "Squawk", "Radar", "Messages", "Groundspeed", "Altitude", "Rate_of_climb", "Category"})

	type Aircraft struct {
		Hex           string  `json:"hex"`
		Flight        string  `json:"flight"`
		Lat           float64 `json:"lat"`
		Lon           float64 `json:"lon"`
		Alt           int     `json:"alt"`
		Track         float64 `json:"track"`
		Speed         int     `json:"speed"`
		Squawk        string  `json:"squawk"`
		Radar         string  `json:"radar"`
		Messages      int     `json:"messages"`
		Groundspeed   float64 `json:"gs"`
		Altitude      int     `json:"alt_baro"`
		Rate_of_climb int     `json:"baro_rate"`
		Category      string  `json:"category"`
	}

	type Flight_log struct {
		Now      float64    `json:"now"`
		Messages int        `json:"messages"`
		Aircraft []Aircraft `json:"aircraft"`
	}

	// we initialize our Users array
	//var users Users
	//

	data := Flight_log{}

	// we unmarshal our byteArray which contains our
	// jsonFile's content into 'users' which we defined above
	err = json.Unmarshal(byteValue, &data)
	if err != nil {
		fmt.Println(err)
	}
	// we iterate through every user within our users array and
	// print out the user Type, their name, and their facebook url
	// as just an example
	//
	fmt.Println("Start")
	for i := 0; i < len(data.Aircraft); i++ {

		timestamp := fmt.Sprintf("%f", data.Now)
		lat := fmt.Sprintf("%f", data.Aircraft[i].Lat)
		lon := fmt.Sprintf("%f", data.Aircraft[i].Lon)
		alt := fmt.Sprintf("%d", data.Aircraft[i].Alt)
		track := fmt.Sprintf("%f", data.Aircraft[i].Track)
		speed := fmt.Sprintf("%d", data.Aircraft[i].Speed)
		messages := fmt.Sprintf("%d", data.Aircraft[i].Messages)
		groundspeed := fmt.Sprintf("%f", data.Aircraft[i].Groundspeed)
		altitude := fmt.Sprintf("%d", data.Aircraft[i].Altitude)
		rate_of_climb := fmt.Sprintf("%d", data.Aircraft[i].Rate_of_climb)

		// Write to csv file
		// csv_writer.Write([]string{"Now", "Hex", "Flight", "Lat", "Lon", "Alt", "Track", "Speed", "Squawk", "Radar", "Messages", "Groundspeed", "Altitude", "Rate_of_climb", "Category"})
		//
		csv_writer.Write([]string{timestamp, data.Aircraft[i].Hex, data.Aircraft[i].Flight, lat, lon, alt, track, speed, data.Aircraft[i].Squawk, data.Aircraft[i].Radar, messages, groundspeed, altitude, rate_of_climb, data.Aircraft[i].Category})
		//
	}
	fmt.Println("End")
}
