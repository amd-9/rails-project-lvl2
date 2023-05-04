# frozen_string_literal: true

module AncestryHelper
  def arranged_tree_table_rows(tree)
    tree.each do |node, children|
      concat render partial: 'comments/comment', object: node
      arranged_tree_table_rows(children) if children.present?
    end
  end
end
