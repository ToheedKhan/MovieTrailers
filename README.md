# Movie Trailer App
This app fetch movies data from [TMDB](https://www.themoviedb.org) and display it in a List.
User can search movies in displayed list by name. Upon movie selection, user will navigate to detail screen.

**TMDB API** is free. You need to sign up to get an API key.

## Framework Used

* PromiseKit
* SDWebImage


## Architecture  
Clean 

<kbd>
<img width="733" alt="architecture_diagram" src="https://user-images.githubusercontent.com/4839453/185815863-7bbeda56-6c16-4864-98da-b6ef7cf0a790.png">
</kbd>

## Flow Diagram
<kbd>
<img width="400" alt="Flow Diagram" src="https://user-images.githubusercontent.com/4839453/185610509-2420fb85-a779-4393-b9fe-008983b855a1.png">
</kbd>

## Screenshots
<!--
<p float="left">
<kbd>
<img src="https://user-images.githubusercontent.com/4839453/185611207-2e107875-9427-4d51-8338-4ecad8ce20be.png" alt="Movie List" title="Movie List" width="414" height="896">
</kbd>

<kbd>
<img src="https://user-images.githubusercontent.com/4839453/185610956-84341074-f866-4ad9-9e44-3eb0720f7f99.png" alt="Movie Detail" title="Movie Detail" width="414" height="896">
</kbd>

<kbd>
<img src="https://user-images.githubusercontent.com/4839453/185611180-2976bc37-24bf-4200-b161-151c6fc4ae15.png" alt="Movie Search" title="Movie Search" width="414" height="896">
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
<img src="https://user-images.githubusercontent.com/4839453/185611207-2e107875-9427-4d51-8338-4ecad8ce20be.png" alt="Movie List" title="Movie List" >
</kbd></td>
<td valign="top"><kbd>
<img src="https://user-images.githubusercontent.com/4839453/185610956-84341074-f866-4ad9-9e44-3eb0720f7f99.png" alt="Movie Detail" title="Movie Detail" >
</kbd></td>
<td valign="top"><kbd>
<img src="https://user-images.githubusercontent.com/4839453/185611180-2976bc37-24bf-4200-b161-151c6fc4ae15.png" alt="Movie Search" title="Movie Search">
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
