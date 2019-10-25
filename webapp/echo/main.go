package main

import (
	"fmt"
	"log"
	"os"

	"github.com/labstack/echo"
)

func main() {
	networks := []string{
		"10.0.0.0/8",
		"172.16.0.0/12",
		"192.168.0.0/16",
		"127.0.0.0/8",
		"::1/128",
	}

	fmt.Sprintf("%s", networks)

	e := echo.New()
	e.Use(func(next echo.HandlerFunc) echo.HandlerFunc {
		return func(c echo.Context) error {
			if err := next(c); err != nil {
				c.Error(err)
			}

			output := fmt.Sprintf("%#v", c.Request().Header)

			os.Stdout.Write([]byte(output + "\n"))
			return next(c)
		}
	})

	log.Fatal(e.Start(":9001"))
}
