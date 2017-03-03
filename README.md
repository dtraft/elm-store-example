# Elm Architecture with Store

### About:

Elm is amazing for some reasons - the time traveling debugger, the compiler, and the type safety.
And the Elm Architecture provides a clear way to structure applications that is easy to reason about.

That being said, at it's heart, this structure has a strange paradox.  While there is a single global state, child component typically only have access to the portion of state that they define.  This works well for small applications, but for larger projects where state may need to be accessed and modified from just about anywhere.  Using React/Redux/Reselect in tandem handles this scenario elegantly and allows for important Shared State (such as entities loaded from an API) to be decoupled from the UI by pulling into a global store.

In this example, I've tried to replicate all the things that make that pattern powerful within the framework of the Elm Architecture. This is heavily inspired by Rob Ashton's [excellent article](http://codeofrob.com/entries/a-few-notes-on-elm-0.17---composing-applications.html) on Composing Applications in Elm.

You can see it live here: [https://dtraft.github.io/elm-store-example/](https://dtraft.github.io/elm-store-example/)

Pull requests, feedback, and suggestions welcome!


### Install:
Clone this repo into a new project folder, e.g. `my-elm-project`:

Install all dependencies using the handy `reinstall` script:
```
npm run reinstall
```
*This does a clean (re)install of all npm and elm packages, plus a global elm install.*


### Serve locally:
```
npm start
```
* Access app at `http://localhost:8080/`
* Get coding! The entry point file is `src/elm/Main.elm`
* Browser will refresh automatically on any file changes..


### Build & bundle for prod:
```
npm run build
```

* Files are saved into the `/dist` folder
* To check it, open `dist/index.html`
