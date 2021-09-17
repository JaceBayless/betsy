require "spec_helper"

describe Betsy::Review do
  describe "get_reviews_by_shop" do
    it "gets the reviews for a shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/reviews")
        .to_return(status: 200, body: REVIEWS)
      reviews = Betsy::Review.get_reviews_by_shop(1)
      review = reviews.first
      expect(reviews).to be_an_instance_of Array
      expect(review).to be_kind_of Betsy::Review
      expect(review.shop_id).to eq 1
      expect(review.listing_id).to eq 1
      expect(review.transaction_id).to eq 1
      expect(review.buyer_user_id).to eq 1
      expect(review.rating).to eq 0
      expect(review.review).to eq "string"
      expect(review.language).to eq "string"
      expect(review.image_url_fullxfull).to eq "string"
      expect(review.create_timestamp).to eq 946684800
      expect(review.update_timestamp).to eq 946684800
    end
  end
end
