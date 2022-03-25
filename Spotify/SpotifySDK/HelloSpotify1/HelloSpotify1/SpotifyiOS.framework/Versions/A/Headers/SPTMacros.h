#ifndef SPT_MACROS
#define SPT_MACROS

#ifdef __cplusplus
#define SPT_EXPORT extern "C" __attribute__((visibility("default")))
#else
#define SPT_EXPORT extern __attribute__((visibility("default")))
#endif // __cplusplus

#define SPT_DEPRECATED(MESSAGE) __attribute__((deprecated(MESSAGE)))
#define SPT_UNAVAILABLE __attribute__((unavailable))
#define SPT_UNUSED __attribute__((unused))
#define SPT_UNREACHABLE() __builtin_unreachable()

#define SPT_INLINE __attribute__((always_inline)) inline
#define SPT_CONST __attribute__((const))
#define SPT_PURE __attribute__((pure))

#define SPT_NONNULL __attribute__((nonnull))
#define SPT_RETURNS_NONNULL __attribute__((returns_nonnull))

#define SPT_EXPECT(EXPR, VAL) __builtin_expect(!!(EXPR), VAL)
#define SPT_LIKELY(EXPR) SPT_EXPECT(EXPR, 1)
#define SPT_UNLIKELY(EXPR) SPT_EXPECT(EXPR, 0)

#define SPT_MAX_POW2(TYPE_MAX) ((TYPE_MAX >> 1) ^ TYPE_MAX)

#define SPT_EXPR_OR_ZERO(EXPR) __builtin_choose_expr(SPT_TYPE_IS_VOID(EXPR), 0, (EXPR))
#define SPT_TYPE_IS_VOID(EXPR) __builtin_types_compatible_p(typeof(EXPR), void)

/**
 Check if the receiver responds to a selector, then send the message,
 along with the provided parameters.

 The purpose of this macro, other than to make code less cluttered, is to make
 it impossible to accidentally check for a selector but send a different message.

 @param RECEIVER The object to which the message will be sent.
 @param RESULT[out] A pointer to which the return value will be assigned.
 @param ... 0-4 arguments.
 \code{.m}
    BOOL result = NO;
    SPT_OPTIONAL_MESSAGE_SEND(self.delegate, &result, someThingie, self, didSomethingWith, someObject);
    // Expands to the following:
    do {
        if ([self.delegate respondsToSelector:@selector(someThingie:didSomethingWith:)])
            *(result) = [self.delegate someThingie:self didSomethingWith:someObject)];
    } while (0);
 \endcode
*/
#define SPT_OPTIONAL_MESSAGE_SEND(RECEIVER, RESULT, ...) do { \
    if ([RECEIVER respondsToSelector:@selector(SPT_CONCAT_SELECTOR(__VA_ARGS__))]) \
        *(RESULT) = [RECEIVER SPT_CONCAT_METHOD(__VA_ARGS__)]; \
} while (0)

/**
 Like SPT_OPTIONAL_MESSAGE_SEND but ignores the return value.
 @param RECEIVER The object to which the message will be sent.
 @param ... 0-4 arguments.
*/
#define SPT_OPTIONAL_MESSAGE_SEND_(RECEIVER, ...) do { \
    if ([RECEIVER respondsToSelector:@selector(SPT_CONCAT_SELECTOR(__VA_ARGS__))]) \
        [RECEIVER SPT_CONCAT_METHOD(__VA_ARGS__)]; \
} while (0)

// Some boilerplate for SPT_OPTIONAL_MESSAGE_SEND[_]
#define SPT_CONCAT_METHOD8(A, _1, B, _2, C, _3, D, _4) A:_1 B:_2 C:_3 D:_4
#define SPT_CONCAT_METHOD6(A, _1, B, _2, C, _3) A:_1 B:_2 C:_3
#define SPT_CONCAT_METHOD4(A, _1, B, _2) A:_1 B:_2
#define SPT_CONCAT_METHOD2(A, _1) A:_1
#define SPT_CONCAT_METHOD1(A) A

#define SPT_CONCAT_SELECTOR8(A, _1, B, _2, C, _3, D, _4) A:B:C:D:
#define SPT_CONCAT_SELECTOR6(A, _1, B, _2, C, _3) A:B:C:
#define SPT_CONCAT_SELECTOR4(A, _1, B, _2) A:B:
#define SPT_CONCAT_SELECTOR2(A, _1) A:
#define SPT_CONCAT_SELECTOR1(A) A

#define SPT_PICK_CONCAT_MACRO(_1, _2, _3, _4, _5, _6, _7, _8, NAME, ...) NAME

#define SPT_CONCAT_METHOD(...) SPT_PICK_CONCAT_MACRO(__VA_ARGS__, \
    SPT_CONCAT_METHOD8, SPT_CONCAT_METHOD7, SPT_CONCAT_METHOD6, SPT_CONCAT_METHOD5, \
    SPT_CONCAT_METHOD4, SPT_CONCAT_METHOD3, SPT_CONCAT_METHOD2, SPT_CONCAT_METHOD1)(__VA_ARGS__)

#define SPT_CONCAT_SELECTOR(...) SPT_PICK_CONCAT_MACRO(__VA_ARGS__, \
    SPT_CONCAT_SELECTOR8, SPT_CONCAT_SELECTOR7, SPT_CONCAT_SELECTOR6, SPT_CONCAT_SELECTOR5, \
    SPT_CONCAT_SELECTOR4, SPT_CONCAT_SELECTOR3, SPT_CONCAT_SELECTOR2, SPT_CONCAT_SELECTOR1)(__VA_ARGS__)

#endif // SPT_MACROS
