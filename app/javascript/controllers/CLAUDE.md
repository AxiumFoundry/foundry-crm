# Stimulus Controllers

## Controllers

| Controller | Purpose | Targets |
|---|---|---|
| `navbar_controller` | Mobile menu toggle | `menu` |
| `modal_controller` | Modal close on backdrop/button click | none |
| `form_controller` | Form validation, submit button enable/disable | `submit` |
| `hello_controller` | Default Stimulus example | none |

## Details

### navbar_controller
- `toggle()` - Toggles "hidden" class on menu target
- `close()` - Closes menu if open

### modal_controller
- `close(event)` - Closes modal on backdrop or close button click
- `stopPropagation(event)` - Prevents event bubbling through modal content

### form_controller
- `connect()` - Validates form on controller connect
- `validateForm()` - Enables/disables submit button based on HTML5 form validity

## Conventions

- Clean up event listeners in `disconnect()`
- Use Turbo for page navigation, Stimulus for UI behavior only
- Keep controllers small and focused on one responsibility
- Use `data-action` attributes in HTML, not addEventListener in JS
