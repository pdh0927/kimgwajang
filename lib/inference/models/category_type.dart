




enum CategoryType {
    CULTURE_AND_TOURISM_AND_SPORTS('문화·관광·체육'),
    TRAFFIC('교통'),
    WELFLARE('복지'),
    WOMEN_AND_FAMILY_AND_EDUCATION('여성·가족·교육'),
    HEALTH_AND_HYGIENE('건강·보건·위생'),
    INDUSTRY_AND_ECONOMY('산업·경제'),
    ENVIRONMENT('환경'),
    FIRE_AND_SAFETY('소방·안전'),
    URBAN_HOUSING_AND_CONSTRUCTION('도시주택·건설'),
    ADMINISTRATION_AND_FINANCE_AND_TAXATION('행정·재정·세정'),
    UNKNOWN('알 수 없음');

    const CategoryType(this.value);

    final String value;

    static CategoryType fromString(String str) {
        for(final type in CategoryType.values) {
            if (type.value == str) {
                return type;
            }
        }
        return CategoryType.UNKNOWN;
    }

    static String asString(CategoryType type) {
        return type.value;
    }
}
