package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	fs := http.FileServer(http.Dir("./dist"))

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		_, err := os.Stat("./dist" + r.URL.Path)
		if os.IsNotExist(err) {
			http.ServeFile(w, r, "./dist/index.html")
			return
		}
		fs.ServeHTTP(w, r)
	})

	log.Println("server app..")
	if err := http.ListenAndServe(":3000", nil); err != nil {
		log.Fatal(err)
	}
}
