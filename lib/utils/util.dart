String zero(int? a) => a != null ? a < 10 ? '0$a' : '$a' : '';
