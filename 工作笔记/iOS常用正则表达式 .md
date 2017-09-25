# iOS常用正则表达式 

> 使用正则表达式判断手机号是否合法

```
+ (BOOL) IsPhoneNumber:(NSString *)number
{
    NSString *phoneRegex1=@"1[34578]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}
```

> 使用正则表达式判断邮箱是否合法

```
+ (BOOL) IsEmailAdress:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}
```


> 使用正则表达式判断身份证是否合法


```
+ (BOOL) IsIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
}
```

> 使用正则表达式判断银行卡是否合法

```
+ (BOOL) IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}
```



