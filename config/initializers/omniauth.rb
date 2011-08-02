Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '88wjkbwL5nuEpHgwEwStA', 'zXX4aUQeoB3obnBDnGBxnIqXKUVXHq3nZDjYqZDpaY'
  provider :facebook, 'CONSUMER_KEY', 'APP_SECRET'
  provider :linked_in, '2mSbq_57emLImly168kg-HXH_P-9_ayy314TZAOmWXRRE5YnWt4dij0UpSnqi7oS', 'DVpkMPzA3uloBdMCFewu2oZcB00nHP1Rf6ucgUwtQ8ohHDERpz6foJil_2OjZU73'
end