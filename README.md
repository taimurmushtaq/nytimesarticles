# NYTimes App

The NYTimes App is built with Swift and SwiftUI, providing a seamless user experience for viewing and searching the most popular articles.

## Features
* Fetch and display the most viewed articles.
* Search and filter articles by title.
* View detailed information about each article.

## Architecture

The app follows the MVVM (Model-View-ViewModel) pattern to separate the business logic from the UI, promoting testability and maintainability.

## Design Patterns
* Factory Pattern: Used to create instances of different screens.
* Coordinator Pattern: Handles navigation between screens to decouple the view controllers from navigation logic.

## Project Structure

* Features: Contains the core functionalities of the app. Each feature has its own directory with its ViewModels, models, and network services.
* Navigation: Contains files responsible for app navigation and routing.
* Core: Includes shared components such as view modifiers, network clients, enums, constants, and utility classes used across the app.

## Unit Tests
* Articles.json: A local mock file to simulate API responses and avoid external calls during testing.
* ViewModel Tests: Unit tests are written for the ViewModels to validate business logic.

## Version
1.0

## Developed By
Taimur Mushtaq
