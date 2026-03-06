use v5.42.0;
use feature 'class';
no warnings 'experimental::class';
#
class Protocol::Noise v0.1.0 {
    use Protocol::Noise::HandshakeState;
    use Protocol::Noise::CipherState;
    use Protocol::Noise::SymmetricState;
    use Protocol::Noise::Pattern;
    use Crypt::PK::X25519;
    #
    field $handshake_state;
    field $prologue : param //= '';

    method initialize_handshake (%params) {

        # Params: pattern, initiator, s, e, rs, re
        $handshake_state = Protocol::Noise::HandshakeState->new(
            prologue  => $prologue,
            pattern   => $params{pattern}   // 'XX',
            initiator => $params{initiator} // 1,
            s         => $params{s},
            e         => $params{e},
            rs        => $params{rs},
            re        => $params{re},
            psks      => $params{psks} // []
        );
    }

    # Wrapper methods for compatibility/convenience
    method write_message ( $payload //= '' ) { $handshake_state->write_message($payload); }
    method read_message  ($message)          { $handshake_state->read_message($message); }
    method split () { $handshake_state->split(); }

    # For backward compatibility with the old specific XX impl (if needed)
    method initialize_state ( $proto_name //= 'Noise_XX_25519_ChaChaPoly_SHA256' ) {
        my ($p_name) = $proto_name =~ /Noise_([^_]+)_/;
        $self->initialize_handshake( pattern => $p_name // 'XX' );
    }

    # Expose internal states for debugging/tests
    method h ()  { $handshake_state->symmetric_state->h }
    method ck () { $handshake_state->symmetric_state->ck }
};
#
1;
