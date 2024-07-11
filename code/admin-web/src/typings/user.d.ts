declare namespace User {

    interface User {
        firstName: string | null;
        lastName: string | null;
        email: string | null;
        password: string | null;
    }


    interface UserAuth {
        firstName?: string
        lastName?: string
        email?: string
        password?: string
        reenteredPassword?: string
    }
}