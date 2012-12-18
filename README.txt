short lambda implementation based on the new Haxe marco features.
Examples:

using ArrayExtensions;
// [1, 2].mapM(_+1)
// [1, 2].filterM(_ > 1) 

[1, 2].l_(map, _+1)
