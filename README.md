# enumerable_methods
>Implementation of Ruby Enumerable methods.

## Built With

- Ruby.

## Implemented methods
`my_each`
`my_each_with_index`
`my_select`
`my_all?`
`my_any?`
`my_none?`
`my_count`
`my_map`
`my_inject`

## Getting Started 
**In order to start `name_of_method` you can use `name_of_method` either with a block or with special use cases specific to each one**
**for `my_each`, `my_each_with_index`, `my_select`, `my_map` if you didn't use a block it will return enumerator**
**If you didn't use a block with `my_all?`, `my_any?`, `my_none?` it will return true or false based on all of the elements of the enum**
**for `my_count` if you didn't pass anything it will count all of the enum elements. However, it will count the elements equal to the argument if you passed one**
**you can pass either a proc or a block to `my_map` method. However, a proc has higher presedence over a block**
**if you used `my_inject` with a block you can pass an initial value as an argument like `my_inject(value){block}` or without an initial and it will use the first item as the intial value for the accumulator**
**you can use `my_inject` with a symbol representing an operation instead of a block**
**if you used `my_inject` with a symbol you can also pass an initial value like `my_inject(intial,sym)` or without initial `my_inject(sym)`**
## Authors

👤 **Mohamed Sabry**


- Github: [@mohamedSabry0](https://github.com/mohamedSabry0)
- Twitter: [@mohsmh0](https://twitter.com/mohsmh0)
- Linkedin: [Mohamed Sabry](https://www.linkedin.com/in/mohamed-sabry-1322b1105/)


👤 **Juan Jacobo Hincapie Montes**

- Gmail: [@gmail](jacobo12.montes@gmail.com)
- Github: [@githubhandle](https://github.com/jacobo12montes)
- Twitter: [@twitterhandle](https://twitter.com/HincapieMontes)
- Linkedin: [linkedin](https://www.linkedin.com/in/juan-jacobo-hincapi%C3%A9-montes-93975210b/)


## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/jacobo12montes/enumerable_methods/issues/).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](lic.url) licensed.