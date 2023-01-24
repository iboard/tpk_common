defmodule TpkCommonHTMLTest do
  use ExUnit.Case
  doctest TPK.Common.HTML

  import TPK.Common.HTML, only: [md_to_html!: 1, md_file_to_html!: 1]

  describe "Basic string to html" do
    test "module exists" do
      assert is_list(TPK.Common.__info__(:functions))
    end

    test ".md_to_html! nil" do
      assert md_to_html!(nil) == ""
    end

    test ".md_to_html! empty string" do
      assert md_to_html!("") == ""
    end

    test ".md_to_html! simple string" do
      assert md_to_html!("this becomes a paragraph") == "<p>\nthis becomes a paragraph</p>\n"
    end
  end

  describe "HTML Convenience Functions" do

    test "md_file_to_html!(valid_file)" do
      assert md_file_to_html!("LICENSE.md") =~ "APACHE"
    end

    test "md_file_to_html!(non existing file)" do
      assert md_file_to_html!("unknown.md") == "ERROR: {:error, :enoent}"
    end
    
  end
end
