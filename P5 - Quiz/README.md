# IWEB - Project 5
## Authors
Pablo Caraballo Llorente
Mario Penavades Suárez

## Built With
- [Swift](https://www.apple.com/swift/)

## Statement
A web service called Quiz was developed that allowed to introduce questions and then to play them correctly.

On the page https://quiz2019.herokuapp.com this service is displayed. Students can enter this website with a browser to use this service.

The goal of this practice is to create an iOS app using the Swift language that shows a list of all the existing quizzes, and allows you to play to answer them correctly.

A possible implementation of this app would be the one shown in the following images. An initial page shows the list of all the quizzes in a table. Selecting a quiz from this list goes to the second screen, where you can write the answer of the selected quiz and check if it is correct. From the second screen you can access a third screen that shows the existing clues to guess the question.


The code of this web service (implemented with node and express) is available at https://github.com/CORE-UPM/CRM_2017.git. The student can consult this code to see the details of the implementation of the REST API.

The student must design this app creating the screens that he wants, and using the navigation mechanisms between screens that he considers appropriate. However, the list of all quizzes must be displayed using views of the Table View type.

Additionally, the app must meet the following requirements:

GCD must be used so that the application responds smoothly at all times, avoiding blockages that occur when waiting for the data to be downloaded.
It must behave properly when there is no connection to the server.
It must be displayed correctly in any type of terminal, and for any orientation of the screen.
Use icons (desktop, etc.) and start screen.
In order to use the REST API of the web service, students must create an account and create an access token. They can also use one of the existing accounts if they know what their access token is. This token will be used in all requests that are sent to the server. The token can be created or changed by entering the web portal, by logging in, entering the user profile (top right corner), and requesting that a new access token be generated.

In the moodle of the subject there is a pdf document where all the REST API primitives of the Quiz server are described. All the described requests download a different JSON, but for the same type of request, the returned JSON always has the same fields. Use a browser to test the requests and view the format of the returned JSONs. To comfortably view the content and structure of the downloaded JSONs, it is recommended to install an extension in your browser to format JSON documents.

##Upgrades
Convert the stars into buttons that allow you to mark or unmark a quiz as a favorite.

## Demo
![Demo](p5.gif)