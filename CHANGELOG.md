#  CHANGELOG

---

## 0.1.1

### NEW

1. Add type desc for ZMExceptionRecord.
2. Container: Add protect for NSMutableSet.
3. Container: Protect metod -[NSArray subarrayWithRange:].
4. Container: Add protect for -[NSArray initWithObjects:count:].
5. Container: Add protect for -[NSDictionary initWithObjects:forKeys:].
6. Container: Update behavior on exception with method -[NSArray objectsAtIndexes:] to return nil(which was an empty array).
7. Add method to unregister record handler.

### FIXED

1. Add missing typeDesc for kvc type.

## 0.1.0

First release.
