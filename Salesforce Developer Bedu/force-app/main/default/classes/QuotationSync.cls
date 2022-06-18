public interface QuotationSync {

    boolean confirmProductExistByCode(String cproducto);
    Decimal searchProductByCode(String cproducto);
}