package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	sig := make(chan os.Signal, 1)
	signal.Notify(sig, syscall.SIGHUP, syscall.SIGINT, syscall.SIGTERM,	syscall.SIGQUIT)
	go func() {
		<-sig
		fmt.Print("Closing server")
		os.Exit(0)
	}()

	http.HandleFunc("/", func (w http.ResponseWriter, r *http.Request) {
		headers, err := json.MarshalIndent(r.Header, "", "  ")
		if err == nil {
			w.WriteHeader(http.StatusOK)
			_, _ = fmt.Fprintf(w, "Http request %v\n%s\n", r, headers)
			_, _ = fmt.Printf("Http request %v\n%s\n", r, headers)
		} else {
			w.WriteHeader(http.StatusInternalServerError)
			_, _ = fmt.Fprintf(w, "Error %s", err)
		}
	})

	listenOn := ":8080"
	fmt.Println("Listening for http requests on", listenOn)
	err := http.ListenAndServe(listenOn, nil)
	if err != nil {
		panic(err)
	}
}
