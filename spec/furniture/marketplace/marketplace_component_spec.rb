require "rails_helper"

RSpec.describe Marketplace::MarketplaceComponent, type: :component do
  subject(:output) { render_inline(component) }

  let(:component) { described_class.new(marketplace: marketplace, current_person: current_person) }
  let(:marketplace) { create(:marketplace, :ready_for_shopping) }
  let(:current_person) { Guest.new }

  context "when the current person can edit the marketplace" do
    let(:current_person) { create(:person, operator: true) }

    it { is_expected.not_to have_content(I18n.t("marketplace.marketplace.config_missing_explainer_html")) }
    it { is_expected.to have_link(I18n.t("marketplace.marketplace.edit"), href: polymorphic_path(marketplace.location(:edit))) }

    context "when the marketplace is not fully configured" do
      let(:marketplace) { create(:marketplace) }

      it { is_expected.to have_content(I18n.t("marketplace.marketplace.config_missing_explainer_html", edit_link: I18n.t("marketplace.marketplace.edit"))) }
    end
  end

  context "when the current person cannot edit the marketplace" do
    it { is_expected.not_to have_link(I18n.t("marketplace.marketplace.edit"), href: polymorphic_path(marketplace.location(:edit))) }

    context "when the marketplace is not fully configured" do
      let(:marketplace) { create(:marketplace) }

      describe "#render?" do
        subject(:render?) { component.render? }

        it { is_expected.not_to be_truthy }
      end
    end
  end
end
