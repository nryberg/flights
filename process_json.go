// Process a JSON file and return a map of the data
// Write the results to a csv file
//
// Usage: process_json.go -json=<filename.json> -header=true
// Example: process_json.go 1692416726.json -header=true
//

// TODO : Add support for multiple json files
//        Flag for a folder and then iterate
//        You need to pull most of the functionality out
//        of main and into a proper function (or two or three)
//        This will make it easier to read and understand
//        and test.   01/04/2024

package main

import (
	"encoding/csv"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"os"
	"strings"
)

func get_json_data(json_filename string) ([]byte, error) {
	jsonFile, err := os.Open(json_filename) // "1692416726.json")
	// if we os.Open returns an error then handle it
	if err != nil {
		return nil, err
	}
	fmt.Printf("Successfully Opened %s", json_filename)

	filename := strings.TrimSuffix(json_filename, ".json")

	fmt.Println(filename)

	// defer the closing of our jsonFile so that we can parse it later on
	defer jsonFile.Close()
	// read our opened xmlFile as a byte array.
	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	} else {
		return byteValue, nil
	}

}

func open_csv_file(csv_filename string, append bool) (*os.File, error) {
	var csv_file *os.File
	var err error

	if append {
		csv_file, err = os.Open(csv_filename)
		if err != nil {
			return nil, err
		} else {
			return csv_file, nil
		}
	} else {
		csv_file, err = os.Create(csv_filename)
		if err != nil {
			return nil, err
		} else {
			return csv_file, nil
		}
	}
}

func process_json(json_data []byte, csv_writer csv.Writer, print_header bool, append bool) error {
	var err error
	// Write Headers
	if print_header {
		csv_writer.Write([]string{"Now", "Hex", "Flight", "Lat", "Lon", "Alt", "Track", "Speed", "Squawk", "Radar", "Messages", "Groundspeed", "Altitude", "Rate_of_climb", "Category"})
	}

	type Aircraft struct {
		Hex           string  `json:"hex"`
		Flight        string  `json:"flight"`
		Lat           float64 `json:"lat"`
		Lon           float64 `json:"lon"`
		Alt           int     `json:"alt_baro"`
		Track         float64 `json:"track"`
		Speed         float64 `json:"gs"`
		Squawk        string  `json:"squawk"`
		Radar         string  `json:"radar"`
		Messages      int     `json:"messages"`
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
	err = json.Unmarshal(json_data, &data)
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
		hex := data.Aircraft[i].Hex
		flight := data.Aircraft[i].Flight
		lat := fmt.Sprintf("%f", data.Aircraft[i].Lat)
		lon := fmt.Sprintf("%f", data.Aircraft[i].Lon)
		alt := fmt.Sprintf("%d", data.Aircraft[i].Alt)
		track := fmt.Sprintf("%f", data.Aircraft[i].Track)
		speed := fmt.Sprintf("%f", data.Aircraft[i].Speed)
		squawk := data.Aircraft[i].Squawk
		radar := data.Aircraft[i].Radar
		messages := fmt.Sprintf("%d", data.Aircraft[i].Messages)
		groundspeed := fmt.Sprintf("%f", data.Aircraft[i].Speed)
		altitude := fmt.Sprintf("%d", data.Aircraft[i].Alt)
		rate_of_climb := fmt.Sprintf("%d", data.Aircraft[i].Rate_of_climb)
		category := data.Aircraft[i].Category

		// Write to csv file
		//
		csv_writer.Write([]string{timestamp, hex, flight, lat, lon, alt, track, speed, squawk, radar, messages, groundspeed, altitude, rate_of_climb, category})
		//
	}
	if err != nil {
		return err
	} else {
		return nil
	}
}

func main() {

	// json_filename := os.Args[1]
	json_filename := flag.String("json", "1692416726.json", "JSON filename")
	print_header := flag.Bool("header", true, "Print header")
	output_file := flag.String("output", "output.csv", "Output filename")
	append := flag.Bool("append", false, "Append to output file")

	flag.Parse()

	// Open the csv file for writing
	csv_filename := *output_file

	csv_file, err := open_csv_file(csv_filename, *append)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer csv_file.Close()

	// Create a csv writer
	csv_writer := csv.NewWriter(csv_file)
	defer csv_writer.Flush()

	// Open our jsonFile
	json_data, err := get_json_data(*json_filename)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	err = process_json(json_data, *csv_writer, *print_header, *append)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	fmt.Println("Done")
}
