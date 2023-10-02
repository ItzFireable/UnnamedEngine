package extensions;

class ArrayExtensions {
    public static inline function last<T>(a:Array<T>):T {
        return a[a.length - 1];
    }
}