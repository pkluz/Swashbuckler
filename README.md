# Swashbuckler
Swashbuckler is a tool to formalize and automate the styling of applications.

# Style Classes

Similar to CSS, the swashbuckler allows you to define style classes. Style classes group style properties and automatically trigger the generation of extensions containing convenient accessors to style related information to structs and/or classes with the matching name.

```css
.feedViewController
    backgroundColor #FF00CC
    defaultFont 12pt 'Helvetica-Neue'
```

The above swashbuckler stylesheet will emit the following Swift code on iOS:

```swift
public struct FeedViewControllerStyle {

    public var backgroundColor: UIColor {
        return UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 204.0/255.0, alpha: 255.0/255.0)
    }

    public var defaultFont: UIFont {
        return UIFont(name: "Helvetica-Neue", size: 12.0)! // swiftlint:disable:this force_unwrap
    }
}

extension FeedViewController {
    public var style: FeedViewControllerStyle {
        return FeedViewControllerStyle()
    }
}
```

Please note that your application will _not_ compile _if_ the style classes name couldn't be matched to an existing type. To resolve this issue you will need to adjust the name of your style class.

# Nesting

Blocks can be nested, to allow for hierarchical structuring of your styles. Note the difference between defining a block for a style class and a style element. A style element will not attempt to extend an existing type, instead only a style struct will be generated.

```css
.feedViewController
    backgroundColor #FF00CC
    defaultFont 12pt 'Helvetica-Neue'
    
    #headerView
        isTranslucent true
```

The above swashbuckler stylesheet will emit the following Swift code on iOS:

```swift
public struct FeedViewControllerStyle {

    public struct HeaderViewStyle {
        public var isTranslucent: Bool {
            return true
        }
    }

    public var headerViewStyle: HeaderViewStyle {
        return HeaderViewStyle()
    }

    public var backgroundColor: UIColor {
        return UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 204.0/255.0, alpha: 255.0/255.0)
    }

    public var defaultFont: UIFont {
        return UIFont(name: "Helvetica-Neue", size: 12.0)! // swiftlint:disable:this force_unwrap
    }
}

extension FeedViewController {
    public var style: FeedViewControllerStyle {
        return FeedViewControllerStyle()
    }
}
```
