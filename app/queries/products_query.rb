class ProductsQuery
  attr_reader :relation

  def initialize(relation = Product.all)
    @relation = relation
  end

  def order_by_letter(direction)
    return relation unless direction.present?

    relation.order("name #{direction}")
  end

  def order_by_likes_count(direction)
    return relation unless direction.present?

    relation.order("likes_count #{direction}")
  end

  def filter_by_term(term)
    return relation unless term.present?

    relation.where('products.name LIKE ?', "%#{term}%")
  end

  def filter_by_tag(tag)
    return relation unless tag.present?

    relation.joins(products_tags: :tag).where(tags: { id: tag })
  end
end