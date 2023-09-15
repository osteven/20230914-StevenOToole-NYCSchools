# 20230914-StevenOToole-NYCSchools

JP Morgan Coding Challenge

Here are things I would add if I were to spend more time on this:
- Sorting of schools. I would implement this with a menu offering sort by Borough, Name, SAT score, total students… When an option is chosen, I would get ViewModel.schoolDictionary.values, sort, and then refill the ViewModel.currentSelection array. That varaible is a Publisher so the list should automatically reload.
- Searching of schools. Similar implementation. I would filter the array.
- Error-handling. I would propagate any API errors up to the UI. I would use the `alert(isPresented:error:actions:message:)` modifier to show the user what went wrong and a recovery suggestion.
- Localization
- Accessibility
- Landscape mode
- Dark Mode
- iPad layout