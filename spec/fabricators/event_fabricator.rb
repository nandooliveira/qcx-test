Fabricator(:event) do
  event_type { 'ping' }
  delivery   { SecureRandom.uuid }
  signature  { SecureRandom.hex(32) }
  payload    { { 'test' => 'test' } }
end
