# Movie Trailer App
This app fetch movies data from [TMDB](https://www.themoviedb.org) and display it in a List.
User can search movies in displayed list by name. Upon movie selection, user will navigate to detail screen.

**TMDB API** is free. You need to sign up to get an API key.

## Framework Used

* PromiseKit
* SDWebImage


## Architecture  
Clean architecture + MVVM for presentation layer and Coordinator for navigation

Clean architecture help to write reusable, maintainable, highly decoupled and extensible code due to separation of concern using different layers. 

<kbd>
<img width="733" alt="architecture_diagram" src="https://user-images.githubusercontent.com/4839453/187845506-04ccf82a-03d1-485d-9fed-7595b1e85e98.png">
</kbd>

## Flow Diagram
<kbd>
<img width="400" alt="Flow Diagram" src="https://user-images.githubusercontent.com/4839453/185610509-2420fb85-a779-4393-b9fe-008983b855a1.png">
</kbd>

## Screenshots
<!--
<p float="left">
<kbd>
<img src="https://user-images.githubusercontent.com/4839453/188343807-568760bc-553d-40a0-b39a-912fb6c252a4.png" alt="Movie List" title="Movie List" width="414" height="896">
</kbd>

<kbd>
<img src="https://user-images.githubusercontent.com/4839453/188343800-846442a8-ddea-4996-9330-217918ce3da0.png" alt="Movie Detail" title="Movie Detail" width="414" height="896">
</kbd>

<kbd>
<img src="https://user-images.githubusercontent.com/4839453/188343796-550c02b5-afa2-40b5-b1e1-5a1f08de91d8.png" alt="Movie Search" title="Movie Search" width="414" height="896">
</kbd>

</p>
-->

<table width="1200">
<tr>
<td>Display the fetched movies from server in a list </td>
<td>On selection navigates to movie detail screen </td>
<td>Search locally within the list by movie name</td>
</tr>
<tr>
<td valign="top"><kbd>
<img src="https://user-images.githubusercontent.com/4839453/188343807-568760bc-553d-40a0-b39a-912fb6c252a4.png" alt="Movie List" title="Movie List" >
</kbd></td>
<td valign="top"><kbd>
<img src="https://user-images.githubusercontent.com/4839453/188343800-846442a8-ddea-4996-9330-217918ce3da0.png" alt="Movie Detail" title="Movie Detail" >
</kbd></td>
<td valign="top"><kbd>
<img src="https://user-images.githubusercontent.com/4839453/188343796-550c02b5-afa2-40b5-b1e1-5a1f08de91d8.png" alt="Movie Search" title="Movie Search">
</kbd></td>
</tr>
</table>

## Unit Test Cases
### Using **XCTest**

### Coverage
<kbd>
<img width="1679" alt="UnitTestCaseCoverage%" src="https://user-images.githubusercontent.com/4839453/185820379-6aa78779-a122-4d12-ac45-cd8205205828.png">
</kbd>

### Using **Quick & Nimble**
**Branch :- quick-nimble-testing**
