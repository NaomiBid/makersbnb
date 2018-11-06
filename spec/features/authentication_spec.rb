feature 'authentication' do
  scenario 'a user can sign in' do
    User.create_account(email: 'test@example.com', first_name: "John" , last_name: "Doe", password: 'password123' )

    visit '/sessions/new'
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'password123')
    click_button('Sign in')

    expect(page).to have_content 'Book a space'
  end

  scenario 'a user sees an error if they get their email wrong' do
    User.create_account(email: 'test@example.com', first_name: "John" , last_name: "Doe", password: 'password123' )
    visit '/sessions/new'
    fill_in(:email, with: 'nottherightemail@example.com')
    fill_in(:password, with: 'password123')
    click_button('Sign in')
    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user sees an error if they get their password wrong' do
    User.create_account(email: 'test@example.com', first_name: "John" , last_name: "Doe", password: 'password123' )

    visit '/sessions/new'
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'wrongpassword')
    click_button('Sign in')

    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password.'
  end
end
