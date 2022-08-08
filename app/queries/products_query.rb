# frozen_string_literal: true

# Queries for Products Model
class ProductsQuery
  attr_reader :relation

  def initialize(relation = Product.where('deleted_at IS NULL'))
    @relation = relation
  end

  # Method that orders the products by alphabetical order
  def order_by_letter(direction)
    return relation unless direction.present?

    relation.order("name #{direction}")
  end

  # Method that orders the products by the amount of likes
  def order_by_likes_count(direction)
    return relation unless direction.present?

    relation.order("likes_count #{direction}")
  end

  # Method that filters the list of products per name
  def filter_by_term(term)
    return relation unless term.present?

    relation.where('products.name LIKE ?', "%#{term}%")
  end

  # Method that filters the list of products by its tags
  def filter_by_tag(tag)
    return relation unless tag.present?

    relation.joins(products_tags: :tag).where(tags: { id: tag })
  end
end
