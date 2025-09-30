# Teachable home assessment
Take-home assessment for Teachable interview process.

What I've built:
- Ruby on Rails monolith project (backend and frontend)
- `TeachableApi` service to wrap HTTP calls to API
- `Course` and `Enrollment` classes with `ActiveModel::Model` included for `ActiveRecord` functionalities without DB tables
- ERB views with Turbo
- Tailwind CSS for styles

Using the endpoints provided by the Public API, it fetchs and outputs a list
of published courses within the creator's school, including the following information for each course:
- Course name
- Course heading
- Course publishing status
- A list of the names and emails of students actively enrolled in the course, along with the enrollment status and creation date

## AI Usage
I've used AI (Copilot):
- ocasionally to do code completion
- to discuss ideas in 'ask' mode 
- a little bit more in 'agent' mode to help build a better UI

## Next steps
- Improve the caching system, to avoid frequent API calls
- Handle multiple pages in API responses
- Implement testing (with RSpec)

## How to run with Dev Containers
1. Open VSCode 
2. Install `Dev Containers` extension
3. Clone the project locally
4. Run the `Dev Containers: Open Folder in Container...` command and select the project folder
5. Run `bundle install`
6. Fill in the API Key to Rails credentials vault with `VISUAL="code --wait" bin/rails credentials:edit`
```
teachable:
  api_key: "api-key-here"
```
7. Run the Rails server with `rails s`
8. Visit http://localhost:3000/

## How to run with local Ruby on Rails installation
1. Clone the project locally
2. Cd to the project folder, run `bundle install`
3. Fill in the API Key to Rails credentials vault with `VISUAL="code --wait" bin/rails credentials:edit`
```
teachable:
  api_key: "api-key-here"
```
4. Run the Rails server with `rails s`
5. Visit http://localhost:3000/
