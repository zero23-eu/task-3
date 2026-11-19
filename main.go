package main

import (
	"fmt"
	"log"
	"net/http"
	"runtime"
)

func hello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "hello from %s/%s\n", runtime.GOOS, runtime.GOARCH)
}

func main() {
	http.HandleFunc("/", hello)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
