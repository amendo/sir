class Attachment < CMS::AttachmentFu
  acts_as_content :has_media => :attachment_fu
  has_attachment :max_size => 4.megabyte
  
  validates_as_attachment
  # Implement atom_entry_filter for AtomPub support
  # Return hash with content attributes
  def self.atom_entry_filter(entry)
    # Example:
    # { :body => entry.content.xml.to_s }
    {}
  end
end